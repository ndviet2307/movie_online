class ChangeRoleToBeIntegerInMoviesPeople < ActiveRecord::Migration[5.2]
  def change
    change_column :movies_people, :role, :integer, default: 0
    #Ex:- :default =>''
  end
end
