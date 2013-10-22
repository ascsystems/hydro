module Formtastic::Helpers::FormHelper
 
  @@_field_error_proc = @@field_error_proc
  remove_class_variable :@@field_error_proc
 
protected
 
  def with_custom_field_error_proc(&block)
    default_field_error_proc = ::ActionView::Base.field_error_proc
    ::ActionView::Base.field_error_proc = @@_field_error_proc
    yield
  ensure
    ::ActionView::Base.field_error_proc = default_field_error_proc
  end
 
end
