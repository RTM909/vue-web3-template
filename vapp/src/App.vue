<template>
  <div id="app">
    <div id="nav">
      <router-link to="/">Home</router-link> |
      <router-link to="/about">About</router-link>
    </div>
    <h2>{{ account }}</h2>
    <router-view />
  </div>
</template>

<script>
import Web3 from "web3"
import Token from "./contracts/Token.json"

export default {
  name: 'App',
  data() {
    return {
      account: '',
      contract: '',
    }
  },
  methods: {
    async loadWeb3() {
      //for ethereum browser
      if (window.ethereum) {
        window.web3 = new Web3(window.ethereum);
        await window.ethereum.enable();
        //for legacy browsers
      } else if (window.web3) {
        window.web3 = new Web3(window.web3.currentProvider);
        //for invalid response
      } else {
        window.alert("Non-ethereum browser detected");
      }
    },
    async loadBlockchainData() {
      const web3 = window.web3;
      const accounts = await web3.eth.getAccounts(); //load accounts
      this.account = accounts[0] //setting account => store a/c in state obj. in react

      window.ethereum.on(
        "accountsChanged",
        async function () {
          // Time to reload your interface with accounts[0]!
          const accounts = await web3.eth.getAccounts(); //load accounts
          this.account = accounts[0] //setting account => store a/c in state obj. in react
        }.bind(this)
      );

      //loading contracts
      const networkId = await web3.eth.net.getId();
      const networkData = Token.networks[networkId];

      if (networkData) {
        const abi = Token.abi;
        const address = networkData.address;
        const contract = new web3.eth.Contract(abi, address);
        this.contract = contract //this.setState({ contract}) //ES6
      } else {
        window.alert("Smart contract not deployed to detected network");
      }
    }
  },
  mounted() {
    this.loadWeb3()
    this.loadBlockchainData()
  }
}
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
</style>
