# frozen_string_literal:true
# We can set an env variable to point to the browser that we want to run. You can set this up in many ways!
# The project would be run by executing cucumber BROWSER=chrome -t <@some-tagged-test>

Before do
  initialize_wd_session(BrowserConfig::CHROME_DESKTOP)
end

After do
  @browser.quit
end
