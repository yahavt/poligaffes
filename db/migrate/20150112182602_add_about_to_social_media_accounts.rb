class AddAboutToSocialMediaAccounts < ActiveRecord::Migration
  def change
    add_column :social_media_accounts, :about, :text
  end
end
