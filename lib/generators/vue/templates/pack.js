import Vue from 'vue'
import <%= component_name %> from 'components/<%= component_name %>'

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementsByTagName('<%= file_name.dasherize %>')[0]
  const props = JSON.parse(node.getAttribute('data-props'))

  new Vue({
    render: h => h(<%= component_name %>, { props })
  }).$mount(node)
})
