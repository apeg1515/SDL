import React from 'react';

import * as actions from '../actions/Actions';

const Context  = React.createContext();



export class Provider extends React.Component {

    state = {

        user: { 

            token: undefined, 

            auth: { success: true }

        },

    };

    

    componentDidMount() {

        // this.persistState.bind(this);

    }

    actionMethods = () => {

        let newActions = {};

        for(let x in actions) {

            newActions[x] = actions[x].bind(this);

        }

        return newActions;

    };

    

    render() {

        return (

            <Context.Provider value={{ 

                ...this.state,

                ...this.actionMethods(),

            }} >

                {this.props.children}

            </Context.Provider>

        );

    }

}



export function connectWithStore(Container) {



    return class extends React.Component {

        render() {

            return (

                <Context.Consumer>

                    {(context) => <Container {...context} {...this.props} />}

                </Context.Consumer>

            );

        }

    }

}


import React from 'react';
import PropTypes from 'prop-types';
import { Route, Redirect } from 'react-router-dom';

import { connectWithStore } from '../reducers/Store.jsx';

function PrivateRoute({ component: Component, authorized, ...rest }) {
    return <Route {...rest} render={(props) => (authorized === true ? <Component {...props} /> : <Redirect to='/'/>  )} />
}

PrivateRoute.propTypes = {
    authorized: PropTypes.bool,
    component: PropTypes.func,
};

const AuthRoute = (props) => {
    const { user, path, component } = props;
    const creds = user.auth.success ? true : false;
    console.log('user creds', user.auth.success);

    return <PrivateRoute authorized={creds} path={path} component={component} />         
}

AuthRoute.propTypes = {
    status:  PropTypes.object,
    component: PropTypes.func,
    path: PropTypes.string
};

export default connectWithStore(AuthRoute);

export const Context = React.createContext();

export const ContextProvider = ({ providedName, providedState, providedActions, children }) => {

  const [contextProviderState, setContextProviderState] = useState({});
  const [contextProviderActions, setContextProviderActions] = useState({});

  const loadMethods = (state, action) => {
    const newActions = {};
    for (const x in action) {
        // if(action !== undefined) {
        if(Object.prototype.hasOwnProperty.call(action, x)) {
            // newActions[Object.values(x)] = action[x].bind(this);
            newActions[x] = action[x].bind(this);
        }
    }
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
);

