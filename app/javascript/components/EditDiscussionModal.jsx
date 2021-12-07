import { Button, Form, Input, Modal } from "antd";
import React from "react";

const { TextArea } = Input;

class EditDiscussionModal extends React.Component {
    formRef = React.createRef();
    state = {
        visible: false,
    };

    onFinish = (values) => {
        const url = `api/v1/posts/${this.props.id}`;
        fetch(url, {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json",
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify(values),
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
                <span onClick={this.showModal}>
                  edit
                </span>

                <Modal
                    title="Edit away"
                    visible={this.state.visible}
                    onCancel={this.handleCancel}
                    footer={null}
                >
                    <Form ref={this.formRef} layout="vertical" onFinish={this.onFinish}>
                        <Form.Item
                            name="content"
                            label="Fix your thoughts"
                            rules={[
                                { required: true, message: "Have an opinion" },
                            ]}
                        >
                            <TextArea rows={4} />
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

export default EditDiscussionModal;
