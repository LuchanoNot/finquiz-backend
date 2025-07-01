# frozen_string_literal: true

# Register CSV as a valid MIME type
Mime::Type.register "text/csv", :csv
