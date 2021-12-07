import { List, Comment, message } from "antd";
import React from "react";
import AddDiscussionModal from "./AddDiscussionModal";

class Discussions extends React.Component {

    state = {
        discussions: [],
    };

    componentDidMount() {
        this.loadDiscussions();
    }

    loadDiscussions = () => {
        const url = "api/v1/posts/index";
        fetch(url)
            .then((data) => {
                if (data.ok) {
                    return data.json();
                }
                throw new Error("Network error.");
            })
            .then((data) => {
                data.forEach((post) => {
                    const newEl = {
                        key: post.post.id,
                        id: post.post.id,
                        author: post.author.email,
                        avatar: post.gravatar_url,
                        content: post.post.content,
                        datetime: post.post.updated_at,
                        replies: post.replies,
                        actions: [<span onClick={() => this.deleteDiscussion(post.post.id)}>delete</span>]
                    };

                    this.setState((prevState) => ({
                        discussions: [...prevState.discussions, newEl],
                    }));
                });
            })
            .catch((err) => message.error("Error: " + err));
    };

    reloadDiscussions = () => {
        this.setState({ discussions: [] });
        this.loadDiscussions();
    };

    deleteDiscussion = (id) => {
        const url = `api/v1/posts/${id}`;

        fetch(url, {
            method: "delete",
            headers: {
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            }
        })
            .then((data) => {
                if (data.ok) {
                    this.reloadDiscussions();
                    return data.json();
                }
                throw new Error("Network error.");
            })
            .catch((err) => message.error("Error: " + err));
    };

    render() {
        return (
            <>
              <List
                className="comment-list"
                header={`${this.state.discussions.length} discussions`}
                itemLayout="horizontal"
                dataSource={this.state.discussions}
                renderItem={item => (
                    <li>
                      <Comment
                        actions={item.actions}
                        author={item.author}
                        avatar={item.avatar}
                        content={item.content}
                        datetime={item.datetime} >

                        <List
                          dataSource={item.replies}
                          renderItem={reply => (
                              <li>
                              <Comment
                                actions={[<span onClick={() => this.deleteDiscussion(reply.post.id)}>delete</span>]}
                                author={reply.author.email}
                                avatar={reply.gravatar_url}
                                content={reply.post.content}
                                datetime={reply.post.updated_at}
                              />
                              </li>
                          )}
                        />
                      </Comment>

                    <AddDiscussionModal reloadDiscussions={this.reloadDiscussions} buttonText="Reply" parentId={item.id}/>
                    </li>
                )}
              />

              <AddDiscussionModal reloadDiscussions={this.reloadDiscussions} buttonText="New Thread"/>
            </>
        );
    }
}

export default Discussions;
