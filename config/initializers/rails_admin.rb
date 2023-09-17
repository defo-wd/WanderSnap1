RailsAdmin.config do |config|
  config.asset_source = :webpacker

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    member :restore do
      only ['User', 'Post']

      link_icon 'icon-refresh'

      register_instance_option(:pjax?) { false }

      register_instance_option(:visible?) do
        bindings[:object].try(:deleted_at?)
      end

      register_instance_option(:controller) do
        Proc.new do
          @object.restore
          flash[:success] = "Object restored"
          redirect_to back_or_index
        end
      end
    end
  end

  config.model 'User' do
    list do
      scopes [nil, :deleted, :alive]
      field :id
      field :email
      field :created_at
      field :updated_at
      field :deleted_at
    end
  end

  config.model 'Post' do
    list do
      scopes [nil, :deleted]
      field :id
      field :user
      field :created_at
      field :updated_at
      field :deleted_at
    end
  end

  config.model 'Report' do
    list do
      scopes [nil, :deleted]
      field :id
      field :reporter
      field :reported
      field :reported_post
      field :reason
      field :created_at
      field :status
    end

    edit do
      field :reason
      field :status
    end
  end
end
