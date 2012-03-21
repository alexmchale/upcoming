class RemoveExistingPasswords < ActiveRecord::Migration

  def up
    execute "UPDATE users SET encrypted_password=''"
  end

end
