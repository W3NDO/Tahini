RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups


  config.disable_monkey_patching!

  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed
end


RSpec::Matchers.define :have_result_with_lhs_rhs do |result|
  match do |match|
    return false unless match.class == result.class
    return false unless match.lhs == result.lhs
    return false unless match.rhs == result.rhs

    if result.class == Result::Fail and match.message and match.message != result.message
      return false
    end
    true
  end
end
