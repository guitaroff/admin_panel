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
end
