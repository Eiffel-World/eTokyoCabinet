class
	TOKYO_EXAMPLES

create
	make
feature -- Initialization

	make
		do
			print ("%N================ Abstract Database Example ======================%N")
			adb_example
			print ("%N================ Fixed Database Example ======================%N")
			fdb_example
			print ("%N================ B-Tree Database Example ======================%N")
			bdb_example
			print ("%N================ Hash Database Example ======================%N")
			hdb_example
			print ("%N================ Table Database Example ======================%N")
			tdb_example

		end

	adb_example
		-- Abstract Database Example
		local
			adb : ADB_API
			l_key : STRING
		do
			create adb.make

			print ("%N================ open database ======================%N")
			adb.open ("casket.tch")
			check not adb.has_error	end

			print ("%N================ store records ======================%N")
			adb.put_string ("foo", "hop")
			check not adb.has_error	end
			adb.put_string ("bar", "step")
			check not adb.has_error	end
			adb.put_string ("baz", "jump")
			check not adb.has_error	end

			print ("%N================ retrieve records ======================%N")
			print ("%Nkey: foo  -- value:" + adb.get_string ("foo") )
			check adb.get_string ("notexist") = Void end


			print ("%N================ traverse records ======================%N")
			from
				adb.iterator_init
				l_key := adb.iterator_next_string
			until
				l_key = Void
			loop
				print ("%NKey :" + l_key)
				print ("%NValue:" + adb.get_string (l_key) )
				l_key := adb.iterator_next_string
			end

			adb.close
			adb.delete
			check not adb.has_error end
		end


	fdb_example
		-- Fixed Database Example
		local
			fdb : FDB_API
			l_key : STRING
		do
			create fdb.make

			print ("%N================ open database ======================%N")
			fdb.open ("casket.tcf", fdb.owriter.bit_or (fdb.ocreat))
			check not fdb.has_error	end

			print ("%N================ store records ======================%N")
			fdb.put_string ("1", "hop")
			check not fdb.has_error	end
			fdb.put_string ("2", "step")
			check not fdb.has_error	end
			fdb.put_string ("3", "jump")
			check not fdb.has_error	end

			print ("%N================ retrieve records ======================%N")
			print ("%Nkey: foo  -- value:" + fdb.get_string ("1") )
			check fdb.get_string ("4") = Void end


			print ("%N================ traverse records ======================%N")
			from
				fdb.iterator_init
				l_key := fdb.iterator_next_string
			until
				l_key = Void
			loop
				print ("%NKey :" + l_key)
				print ("%NValue:" + fdb.get_string (l_key) )
				l_key := fdb.iterator_next_string
			end

			fdb.close
			fdb.delete
			check not fdb.has_error end
		end

	bdb_example
		-- B-tree Database Example
		local
			bdb : BDB_API
			l_key : STRING
		do
			create bdb.make

			print ("%N================ open database ======================%N")
			bdb.open ("casket.tcb",bdb.bdbowriter.bit_or (bdb.bdbocreat))
			check not bdb.has_error	end

			print ("%N================ store records ======================%N")
			bdb.put_string ("foo", "hop")
			check not bdb.has_error	end
			bdb.put_string ("bar", "step")
			check not bdb.has_error	end
			bdb.put_string ("baz", "jump")
			check not bdb.has_error	end

			print ("%N================ retrieve records ======================%N")
			print ("%Nkey: foo  -- value:" + bdb.get_string ("foo") )
			check bdb.get_string ("notexist") = Void end


			print ("%N================ traverse records ======================%N")
			from
				bdb.iterator_init
				l_key := bdb.iterator_next_string
			until
				l_key = Void
			loop
				print ("%NKey :" + l_key)
				print ("%NValue:" + bdb.get_string (l_key) )
				l_key := bdb.iterator_next_string
			end

			bdb.close
			bdb.delete
			check not bdb.has_error end
		end


	hdb_example
		-- Hash Database Example
		local
			hdb : HDB_API
			l_key : STRING
		do
			create hdb.make

			print ("%N================ open database ======================%N")
			hdb.open ("casket2.tch",hdb.owriter.bit_or (hdb.ocreat))
			check not hdb.has_error	end

			print ("%N================ store records ======================%N")
			hdb.put_string ("foo", "hop")
			check not hdb.has_error	end
			hdb.put_string ("bar", "step")
			check not hdb.has_error	end
			hdb.put_string ("baz", "jump")
			check not hdb.has_error	end

			print ("%N================ retrieve records ======================%N")
			print ("%Nkey: foo  -- value:" + hdb.get_string ("foo") )
			check hdb.get_string ("notexist") = Void end


			print ("%N================ traverse records ======================%N")
			from
				hdb.iterator_init
				l_key := hdb.iterator_next_string
			until
				l_key = Void
			loop
				print ("%NKey :" + l_key)
				print ("%NValue:" + hdb.get_string (l_key) )
				l_key := hdb.iterator_next_string
			end

			hdb.close
			hdb.delete
			check not hdb.has_error end
		end


	tdb_example
		-- Table Database Example
		local
			tdb : TDB_API
			l_key : STRING
		do
			create tdb.make

			print ("%N================ open database ======================%N")
			tdb.open ("casket.tct",tdb.owriter.bit_or (tdb.ocreat))
			check not tdb.has_error	end

			print ("%N================ store records ======================%N")
			tdb.put_string ("foo", "hop")
			check not tdb.has_error	end
			tdb.put_string ("bar", "step")
			check not tdb.has_error	end
			tdb.put_string ("baz", "jump")
			check not tdb.has_error	end

			print ("%N================ retrieve records ======================%N")
			print ("%Nkey: foo  -- value:" + tdb.get_string ("foo") )
			check tdb.get_string ("notexist") = Void end


			print ("%N================ traverse records ======================%N")
			from
				tdb.iterator_init
				l_key := tdb.iterator_next_string
			until
				l_key = Void
			loop
				print ("%NKey :" + l_key)
				print ("%NValue:" + tdb.get_string (l_key) )
				l_key := tdb.iterator_next_string
			end

			tdb.close
			tdb.delete
			check not tdb.has_error end
		end
end -- class TOKYO_EXAMPLES