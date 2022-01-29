import Vue from "vue";
import Vuex from "vuex";
import createPersistedState from "vuex-persistedstate";
import SecureLS from "secure-ls";
const ls = new SecureLS({ encodingType: 'rc4', isCompression: false });
Vue.use(Vuex);

export default new Vuex.Store({
  // Encrypts and compresses (optional) entire vuex state into localstorage automatically
  plugins: [
    createPersistedState({
      storage: {
        getItem: key => ls.get(key),
        setItem: (key, value) => ls.set(key, value),
        removeItem: key => ls.remove(key)
      },
      reducer(val) {
        // Check for which condition, empty (default) state should be sent
        if(true) {
          return {
            // Default vuex state
          }
        }
        return val
      } 
    })
  ],
  state: {},
  mutations: {},
  actions: {},
  getters: {},
  modules: {},
});
