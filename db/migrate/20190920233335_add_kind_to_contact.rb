class AddKindToContact < ActiveRecord::Migration[6.0]
  def change
    add_reference :contacts, :kind, foreign_key: true 
    # Essa sentença significa que estou criando uma referência estrageira dentro da entidade 'contacts', ou seja, kind_id
  end
end
