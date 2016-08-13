class RemoveOneSixThree < ActiveRecord::Migration
  def change
    User.where("email like ?", "%163.com").destroy_all
  end
end
