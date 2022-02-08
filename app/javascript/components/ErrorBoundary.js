import React from 'react';
import ErrorModal from './errors/ErrorModal';

export default class ErrorBoundary extends React.Component {
    constructor(props) {
        super(props);
        this.state = { hasError: false };
    }

    static getDerivedStateFromError(error) {
        return { hasError: true };
    }

    render() {
        if (this.state.hasError) {
            return (
                <ErrorModal />
            )
        }

        return this.props.children;
    }
}