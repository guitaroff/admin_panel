module Trestle
  module Auth
    module TitleHelper
      def trestle_auth_title
        if Trestle.config.auth.logo
          image_tag(Trestle.config.auth.logo)
        elsif Trestle.config.site_logo
          image_tag(Trestle.config.site_logo)
        elsif Trestle.config.site_logo_small
          safe_join([
            image_tag(Trestle.config.site_logo_small, alt: "", class: ""),
            content_tag(:span, I18n.t('admin.auth.heading'))
          ], "\n")
        else
          I18n.t('admin.auth.heading')
        end
      end
    end
  end
end
