Given(/^I have navigated to the TV review page$/) do
  @televisions = PageObjects::Televisions.new
  @televisions.load
end

When(/^I sort the product list according to (.*)$/) do |order|
  @televisions.close.click
  @value_before = @televisions.sort_by.value

  @televisions.sort_by.select order
  expect(@televisions).to have_no_active_loader
end

Then(/^it is sorted correctly according to (.*)$/) do |order|
  expect(@televisions.products).to have_been_sorted_correctly order.downcase
end

Then(/^I am not allowed to do so as a logged out user$/) do
  expect(@televisions.sort_by.value).to eql @value_before
end

Then(/^a promotion banner is displayed for me to sign up$/) do
  expect(@televisions).to have_banner
end

And(/^I clear the results$/) do
  @new_res = @televisions.product_count.text
  @televisions.filters.clear_all.click
end

Then(/^my original view is displayed again$/) do
  expect(@televisions).to have_no_active_loader
  expect(@televisions.product_count.text).not_to eql @new_res
end

When(/^I try to filter on price range$/) do
  @price_range = { :min => '£100', :max => '£200' }
  @televisions.filters.price_min.select @price_range[:min]
  @televisions.filters.price_max.select @price_range[:max]
  expect(@televisions).to have_no_active_loader
end

Then(/^I get TV products displayed for that price range$/) do
  expect(@televisions.products).to be_within_range @price_range
end
