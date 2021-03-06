import React from "react";
import { Layout, Menu } from "antd";

const { Header } = Layout;

export default () => (
  <Header>
    <div className="logo" />
    <Menu theme="dark" mode="horizontal" defaultSelectedKeys={["1"]}>
      <Menu.Item key="1">This Thing</Menu.Item>
      <Menu.Item key="2">Does</Menu.Item>
      <Menu.Item key="3">One Thing</Menu.Item>
    </Menu>
  </Header>
);
