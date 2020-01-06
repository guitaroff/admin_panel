Trestle.resource(:users) do
  menu do
    item :users, icon: "fa fa-star"
  end

  table do
    column :avatar, header: false, align: :center, blank: nil do |user|
      avatar(fallback: user.name) { image_tag(user.avatar_url) if user.avatar? }
    end
    column :name
    column :email, link: true
    actions do |a|
      a.delete unless a.instance == current_user
    end
  end

  form dialog: true do |user|
    row do
      col(sm: 6) do
        form_group :avatar, label: false do
          link_to image_tag(user.avatar_url), user.avatar_url, data: { behavior: "zoom" }
        end if user.avatar?
      end
      col(sm: 6) { file_field :avatar }
    end

    row do
      col(sm: 6) { text_field :email }
      col(sm: 6) { text_field :name }
    end

    unless user.persisted?
      row do
        col(sm: 6) { password_field :password }
        col(sm: 6) { password_field :password_confirmation }
      end
    end
  end

  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center
  #   actions
  # end

  # Customize the form fields shown on the new/edit views.
  #
  # form do |user|
  #   text_field :name
  #
  #   row do
  #     col(xs: 6) { datetime_field :updated_at }
  #     col(xs: 6) { datetime_field :created_at }
  #   end
  # end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:user).permit(:name, ...)
  # end
end
