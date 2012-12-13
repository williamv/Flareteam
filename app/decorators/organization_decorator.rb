class OrganizationDecorator < Draper::Base
  def to_s
    model.name
  end

  def show_link
    h.link_to self, model
  end

  def destroy_link
    return unless model.destroyable?
    h.link_to 'Destroy', model, method: :delete, data: {confirm: 'Are you sure?'}
  end
end
