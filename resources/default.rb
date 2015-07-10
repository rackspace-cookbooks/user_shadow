actions :set
default_action :set

attribute :user, kind_of: String, name_attribute: true
attribute :sp_lstchg, kind_of: String, callbacks: { 'Should be a date in YYYY-MM-DD format' => ->(date) { begin !Date.strptime(date, '%Y-%m-%d').nil? rescue false end } }
attribute :sp_expire, kind_of: String, callbacks: { 'Should be a date in YYYY-MM-DD format' => ->(date) { begin !Date.strptime(date, '%Y-%m-%d').nil? rescue false end } }
attribute :sp_min, kind_of: Integer
attribute :sp_max, kind_of: Integer
attribute :sp_warn, kind_of: Integer
attribute :sp_inact, kind_of: Integer
attribute :chage, kind_of: String, default: '/usr/bin/chage'
