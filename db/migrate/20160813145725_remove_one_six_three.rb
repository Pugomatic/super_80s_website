class RemoveOneSixThree < ActiveRecord::Migration[4.2]
  def change
    User.where("email like ?", "%163.com").destroy_all
  end
end
