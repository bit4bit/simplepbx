json.extract! ivr_menu, :id, :greet_long_id, :greet_short_id, :invalid_sound_id, :exit_sound_id, :timeout, :inter_digit_timeout=2000, :max_failures=integer, :digit_len, :menu_top_digits, :created_at, :updated_at
json.url ivr_menu_url(ivr_menu, format: :json)