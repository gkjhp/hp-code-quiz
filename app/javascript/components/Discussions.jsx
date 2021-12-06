import { List, Comment, message, Popconfirm } from "antd";
import React from "react";
// import AddBeerModal from "./AddBeerModal";

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
                        author: post.post.author.email,
                        avatar: post.gravatar_url,
                        content: post.content,
                        datetime: post.updated_at,
                        replies: post.replies,
                        actions: [<span>reply</span>]
                    };

                    this.setState((prevState) => ({
                        discussions: [...prevState.discssions, newEl],
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
                header={`${this.state.discussions.length} replies`}
                itemLayout="horizontal"
                dataSource={this.state.discussions}
                renderItem={item => (
                    <li>
                      <Comment
                        actions={item.actions}
                        author={item.author}
                        avatar={item.avatar}
                        content={item.content}
                        datetime={item.datetime}
                      />
                    </li>
                )}
              />
            </>
        );
    }
}

export default Discussions;
