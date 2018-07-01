# Vue

This gem is a Vue integration for Rails Webpacker. Rails Sprockets integration is planned. Currently a lot of features are missing and it's not production-ready yet. It allows you to automatically generate Vue components and packs from command line, render your Vue components from either Rails view or controller, prerender components on server and pass props directly to them either for components pre-rendered on server or rendered on client with big degree of customization to fit your application conventions and development workflow.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vue'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vue

## Usage

To install run:

```
rails g vue:install
```

This will create an initializer file in `config/initializers/vue.rb` and initialize components folder. You will be able to customize generators there, no other configuration is available at the moment but is planned.

### Generating component

```
rails g vue:component ComponentName
```

This will generate Vue component in `app/javascripts/components`, which you can customize however you want.

### Rendering Vue Component from Rails view

```
<%= vue_component('ComponentName', { message: 'Hello World' }, prerender: true) %>
```

This will render your component in the view with server-side pre-rendering (`prerender: true` (default `false`)).

## Rendering Vue Component from Rails controller

```
render vue_component: 'ComponentName', props: { message: 'Hello World' }, prerender: true
```

This will render your component from controller with server-side pre-rendering, which defaults to false.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/codeblocs/vue. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Vue project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/codeblocs/vue/blob/master/CODE_OF_CONDUCT.md).
