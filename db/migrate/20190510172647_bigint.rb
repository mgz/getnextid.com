class Bigint < ActiveRecord::Migration[5.2]
  def change
      execute 'ALTER TABLE "public"."counters" ALTER COLUMN "value" TYPE bigint;
'
  end
end
