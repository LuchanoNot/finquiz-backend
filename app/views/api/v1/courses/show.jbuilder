# frozen_string_literal: true

json.partial! "course", course: @course

json.units do
  json.array! @course.units.order(:position) do |unit|
    json.partial! "api/v1/units/unit", unit:
  end
end
