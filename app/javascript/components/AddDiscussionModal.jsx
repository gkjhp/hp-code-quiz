import { Button, Form, Input, Modal } from "antd";
import React from "react";

class AddDiscussionModal extends React.Component {
    formRef = React.createRef();
    state = {
        visible: false,
    };

    onFinish = (values) => {
        const url = "api/v1/posts/create";
        fetch(url, {
            method: "post",
            headers: {
                "Content-Type": "application/json",
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({...values, ...{'parent_id': this.props.parentId}}),
        })
            .then((data) => {
                if (data.ok) {
                    this.handleCancel();

                    return data.json();
                }
                throw new Error("Network error.");
            })
            .then(() => {
                this.props.reloadDiscussions();
            })
            .catch((err) => console.error("Error: " + err));
    };

    showModal = () => {
        this.setState({
            visible: true,
        });
    };

    handleCancel = () => {
        this.setState({
            visible: false,
        });
    };

    render() {
        return (
            <>
                <Button type="primary" onClick={this.showModal}>
                    Create New +
                </Button>

                <Modal
                    title="Add Your Post"
                    visible={this.state.visible}
                    onCancel={this.handleCancel}
                    footer={null}
                >
                    <Form ref={this.formRef} layout="vertical" onFinish={this.onFinish}>
                        <Form.Item
                            name="content"
                            label="Craft your post"
                            rules={[
                                { required: true, message: "Have an opinion" },
                            ]}
                        >
                            <Input placeholder="Your thoughts" />
                        </Form.Item>

                        <Form.Item>
                            <Button type="primary" htmlType="submit">
                                Submit
                            </Button>
                        </Form.Item>
                    </Form>
                </Modal>
            </>
        );
    }
}

export default AddDiscussionModal;
