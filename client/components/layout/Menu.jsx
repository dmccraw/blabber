var React = require("react");
var Router = require("react-router");
var Link = Router.Link;

module.exports = React.createClass({

  handleSignOutLink: function() {
    sessionStorage.setItem("jwt", "");
    location = "/";
  },

  render: function() {
    var signingLink;
    if (this.props.signedIn) {
      signingLink = <li><span onClick={this.handleSignOutLink}>Sign Out</span></li>;
    }
    else {
      signingLink = <li><a href={this.props.origin + '/request_token'}>Sign In</a></li>;
    }

    return (
      <div ip="menu">
        <span id="menu-link" onClick={this.props.sendMenuClick}><span></span></span>
        <div id="menu-list">
          <div className="pure-menu pure-menu-open">
            <span className="pure-menu-heading">Blabber</span>
            <ul>
              <li><Link to="blabs">Blabs</Link></li>
              <li><Link to="about">About</Link></li>
              {signingLink}
            </ul>
          </div>
        </div>
      </div>
    );
  }
});