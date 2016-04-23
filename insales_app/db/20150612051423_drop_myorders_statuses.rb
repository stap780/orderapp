# -*- encoding : utf-8 -*-
class DropMyordersStatuses < ActiveRecord::Migration
    def up
    drop_table :orders_statuses
    end
end
