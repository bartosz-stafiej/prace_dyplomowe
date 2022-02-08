import React, { useState } from 'react';
import Modal from 'react-bootstrap/Modal'
import Alert from 'react-bootstrap/Alert'

const ErrorModal = () => {
    const [show, setShow] = useState(true);

    function handleClose() { setShow(false); }

    return (
        <Modal 
            backdrop={false}
            show={show}
            onHide={handleClose}
        >
            <Alert variant="danger" onClose={() => setShow(false)} dismissible>
                <Alert.Heading>Error!</Alert.Heading>
                <hr />
                <p>
                    Something went wrong.
                </p>
            </Alert>
        </Modal>
    )
};

export default ErrorModal;