# class TimeRangeValidator < ActiveModel::EachValidator
#   def validate_each(record, attribute, value)
#     new_start_at = record.start_at
#     new_end_at   = record.end_at
#
#     return unless new_start_at.present? && new_end_at.present?
#
#     if record.id.present?
#       not_own_periods = Micropost.where('id NOT IN (?) AND start_at <= ? AND end_at >= ?', record.id, new_end_at, new_start_at)
#     else
#       not_own_periods = Micropost.where('start_at <= ? AND end_at >= ?', new_end_at, new_start_at)
#
#       record.errors.add(attribute, 'に重複があります') if not_own_periods.present?
#     end
#   end
# end
