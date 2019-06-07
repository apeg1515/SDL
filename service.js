import React, { useState, useEffect } from 'react';

const Context = React.createContext();

export const ContextProvider = ({
    providedName,
    providedState,
    providedActions,
    type,
    children
}) => {

    const [contextProviderState, setContextProviderState] = useState({});
    const [contextProviderActions, setContextProviderActions] = useState({});

    const loadMethods = (state, action) => {
        const newActions = {};

        Object.keys(action).forEach(key => {
            newActions[key] = action[key].bind(this);
        });
        setContextProviderState(state);
        setContextProviderActions(newActions);
    };

    const destructMethod = () => {
        setContextProviderState({});
        setContextProviderActions({});
    };

    useEffect(() => {
        loadMethods(providedState, providedActions);
        return () => {
            destructMethod();
        };
    }, [providedState, providedActions]);

    const provider = providedName
        ? {
              [providedName]: {
                  ...contextProviderState,
                  ...contextProviderActions
              }
          }
        : {};


        return <Context.Provider value={provider}>{children}</Context.Provider>;
 
};

export const connectWithStore = Container => props => (
    <Context.Consumer>
        {context => <Container {...context} {...props} />}
    </Context.Consumer>
    
    
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    
    
    import React,{ useContext } from 'react';
import PropTypes from 'prop-types';
import { Route, Redirect } from 'react-router-dom';
import { CreateContextReducer } from './App';

function PrivateRoute({ component: Component, authorized, ...rest }) {
    return <Route {...rest} render={(props) => (authorized === true ? <Component {...props} /> : <Redirect to='/'/>  )} />
}

PrivateRoute.propTypes = {
    authorized: PropTypes.bool,
    component: PropTypes.func,
};

const AuthRoute = ({ path, component }) => {
    const credentials = useContext(CreateContextReducer);
    console.log('user creds', credentials);
    return <PrivateRoute authorized={credentials.oauth} path={path} component={component} />
}

AuthRoute.propTypes = {
    status: PropTypes.object,
    component: PropTypes.func,
    path: PropTypes.string
};
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    import { createBrowserHistory } from 'history';
import { Router, Route, Switch } from 'react-router-dom';
import React, { useReducer, createContext } from 'react';
import Container from '@material-ui/core/Container';
import  UserReducer from '../reducers/UserReducer';
import ConsentNavbar from './containers/ConsentNavbar';
import ConsentView from './core/ConsentView';
import AuthRoute from './AuthRoute';

const styles = {
    marginLeft: 0,
    marginRight: 0,
    height: '100%'
};

const initialUser = {
    consent: false,
    oauth: true,
    token: 'secret',
};

const history = createBrowserHistory({});
export const CreateContextReducer = createContext(initialUser);


function PersistantStorage() {
    const get = localStorage.getItem('authorized');
    if (get === null)
        localStorage.setItem('authorized', JSON.stringify({ success: false }));
}

PersistantStorage();

const Routes = () =>  {
    return (
        <Router history={history}>
            <Switch>
               <Route exact path="/" component={() => <ConsentView/>} />
               <AuthRoute exact path="/protected" component={() => <h1>Protected</h1>} />
            </Switch>
        </Router>
    );
};

const App = () => {
    const [ userState, userDispatch ] = useReducer(UserReducer, initialUser);

    return (
        <div style={styles} className="App">
            <ConsentNavbar title='' />
            <Container maxWidth="xl">
                <CreateContextReducer.Provider value={{ userState, userDispatch }}>
                    <Routes />
                </CreateContextReducer.Provider>
            </Container>
        </div>
    );
};


export default App;
    
    
     -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    
    import React, { userReducer } from 'react';
import { ContextReducer, UserReducer } from '../reducers/UserReducer';

const initialUser = {
    oauth: true,
    consent: false,
    uuid: '',
};

export const ContextReducerProvider = ({ children }) => {

    const [user, userDispatchReducer ] = userReducer(UserReducer, initialUser);

    return (
        <ContextReducer.Provider value={{ 
            ...user, 
            ...userDispatchReducer,
        }}>
            {children}
        </ContextReducer.Provider>
    );
};


     -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    
    import { getAuthenticationAndConsent } from '../actions/Actions';

const UserReducer = (state, action) => {
    switch (action.type) {
        case 'AUTHENTICATE':
              getAuthenticationAndConsent();
              return;

        case 'CONSENT_TRUE':
              return [ ...state, { consent: true } ];
        case 'CONSENT_FALSE':
              return [ ...state ];
        default:
              return [ ...state ];
    }
}

export default UserReducer;


     -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    
    
    import React, { useEffect, useContext }from 'react';
import Grid from '@material-ui/core/Grid';
import Container from '@material-ui/core/Container';
import { makeStyles } from '@material-ui/core/styles';
import CircularProgress from '@material-ui/core/CircularProgress';
import { CreateContextReducer } from '../App';

const useStyles = makeStyles(theme => ({
    progress: {
        margin: theme.spacing(2),
    },
}));

const LoadingStatus = ({ className }) => (
    <Container maxWidth="sm">
        <Grid container>
            <CircularProgress size={60} className={className} />
        </Grid>
    </Container>

);

export default function ConsentView () {
    const classes = useStyles();
    const { userDispatch } = useContext(CreateContextReducer);

    const getConsent = () => {
        userDispatch({ type: 'AUTHENTICATE'});
    }

    useEffect(() => {
        getConsent();
    });

    return (
        <div>hello</div>
    );
};


     -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------

import axios from 'axios';

export async function getAuthenticationAndConsent() {
    try {
        const method = await axios.get('http://dummy.restapiexample.com/api/v1/employees');

        if(method) {
            console.log(method)
            return ({ response: method.response });
        }

    } catch(err) {
        return ({ err });
    }
}
    
