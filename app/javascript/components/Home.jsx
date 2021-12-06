import { Layout } from "antd";
import React from "react";
import Discussions from "./Discussions";
import Header from "./Header";

const { Content, Footer } = Layout;

export default () => (
  <Layout className="layout">
    <Header />
    <Content style={{ padding: "0 50px" }}>
      <div className="site-layout-content" style={{ margin: "100px auto" }}>
        <h1>Numberwang Online</h1>
        <Discussions />
      </div>
    </Content>
    <Footer style={{ textAlign: "center" }}>This is the bottom</Footer>
  </Layout>
);
