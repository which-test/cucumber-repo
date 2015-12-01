require 'site_prism'
require 'capybara/node/matchers'

module PageObjects

  #Product section
  class Products < SitePrism::Section

    elements :products_listed_recently_tested, '.product-listing__tested-date'
    elements :products_listed_price, '.product-listing__price'
    elements :products_listed_recently_launched, '.product-listing__launch-date'
    elements :products_listed_screen, '.product-listing__key-fact'


    def get_products_length
      products_listed_screen.length
    end

    def within_range?(price_range)
      products_listed_price.all? do |prod|
        parse_text(prod.text).between? parse_text(price_range[:min]), parse_text(price_range[:max])
      end
    end

    def has_been_sorted_correctly?(value)
      products_text = get_product_value value
      products_text.sort do |curr_prod, next_prod|
        if value.match /low to high/
          curr_prod <=> next_prod
        else
          next_prod <=> curr_prod
        end
      end.eql? products_text
    end

    private

    def get_product_value(value)
      match_object = value.match /recently tested|recently launched|price|screen/
      if match_object
        method_call = match_object[0].gsub(/\s/, '_')
        return self.send("products_listed_#{method_call}").collect do |p|
          parse_text p.text
        end
      end
      return []
    end

    def parse_text(value)
      if value.match /^\d|[£]/
        return value.gsub(/[^0-9\.]*/, "").to_i
      else
        Date.parse value
      end
    end

  end

  # Left filter section
  class Filters < SitePrism::Section
    element :price_min, '#search_range_55_price_lower'
    element :price_max, '#search_range_55_price_upper'
    element :clear_all, '.action-clear-all'
  end

# The page object containing all sections and elements
  class Televisions < SitePrism::Page
    set_url BASE_URL + '/reviews/televisions'

    section :filters, Filters, '.product-filters-inner'
    section :products, Products, 'ul.products'

    element :banner, :xpath, '//iframe[contains(@id, "google_ads_iframe")]'
    element :close, '.dfp-close'
    element :sort_by, '.sort-selector'
    element :product_count, '.product-count'

    def has_no_active_loader?
      has_no_css? '.loading-indicator'
    end

  end

end