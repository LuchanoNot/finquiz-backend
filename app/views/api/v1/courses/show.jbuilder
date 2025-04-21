# frozen_string_literal: true

json.extract! @course, :id, :name, :description

json.units do
  json.array! @course.units.order(:position) do |unit|
    json.partial! "api/v1/units/unit", unit:
  end
end
