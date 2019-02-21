class ChangeDefaultInfoForEvents < ActiveRecord::Migration[5.2]
  def up
    change_column_default :events, :info, 'no information provided'
  end

  def down
    change_column_default :events, :info, 'no further information provided'
  end
end
