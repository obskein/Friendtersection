# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{faraday}
  s.version = "0.4.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["rick"]
  s.date = %q{2010-05-28}
  s.description = %q{HTTP/REST API client library with pluggable components}
  s.email = %q{technoweenie@gmail.com}
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = [".document", ".gitignore", "LICENSE", "README.rdoc", "Rakefile", "VERSION", "faraday.gemspec", "lib/faraday.rb", "lib/faraday/adapter/net_http.rb", "lib/faraday/adapter/patron.rb", "lib/faraday/adapter/test.rb", "lib/faraday/adapter/typhoeus.rb", "lib/faraday/builder.rb", "lib/faraday/connection.rb", "lib/faraday/error.rb", "lib/faraday/middleware.rb", "lib/faraday/request.rb", "lib/faraday/request/active_support_json.rb", "lib/faraday/request/yajl.rb", "lib/faraday/response.rb", "lib/faraday/response/active_support_json.rb", "lib/faraday/response/yajl.rb", "test/adapters/live_test.rb", "test/adapters/test_middleware_test.rb", "test/adapters/typhoeus_test.rb", "test/connection_app_test.rb", "test/connection_test.rb", "test/env_test.rb", "test/helper.rb", "test/live_server.rb", "test/request_middleware_test.rb", "test/response_middleware_test.rb"]
  s.homepage = %q{http://github.com/technoweenie/faraday}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{HTTP/REST API client library}
  s.test_files = ["test/adapters/live_test.rb", "test/adapters/test_middleware_test.rb", "test/adapters/typhoeus_test.rb", "test/connection_app_test.rb", "test/connection_test.rb", "test/env_test.rb", "test/helper.rb", "test/live_server.rb", "test/request_middleware_test.rb", "test/response_middleware_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 1.0.1"])
      s.add_runtime_dependency(%q<addressable>, [">= 2.1.1"])
    else
      s.add_dependency(%q<rack>, [">= 1.0.1"])
      s.add_dependency(%q<addressable>, [">= 2.1.1"])
    end
  else
    s.add_dependency(%q<rack>, [">= 1.0.1"])
    s.add_dependency(%q<addressable>, [">= 2.1.1"])
  end
end
