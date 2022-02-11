class UserBlueprint < Blueprinter::Base
    identifier :id

    fields :email,
           :created_at,
           :updated_at

    view :with_auth do
        field :tokens do |_, options|
            options[:tokens]
        end
    end
end