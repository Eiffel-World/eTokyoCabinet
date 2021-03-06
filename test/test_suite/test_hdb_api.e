note
	description: "Summary description for {TEST_HDB_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HDB_API
inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			create hdb.make
		end

	on_clean
			-- <Precursor>
		do
			hdb.close
			hdb.delete
		end

feature -- Test routines

	test_open_modes
		do
				-- Open as WRITER AND CREATE
				hdb.open_writer_create ("casket.tch")

				assert("open mode as writer", hdb.is_open_mode_writer)

				-- Check the invariant
				assert("not_open_as_reader_and_writder", hdb.is_open implies (not (hdb.is_open_mode_reader and hdb.is_open_mode_writer)))
				assert("open_as_reader               " , (hdb.is_open and then hdb.is_open_mode_reader) implies (not hdb.is_open_mode_writer))
				assert("open_as_writer				  ", (hdb.is_open and then hdb.is_open_mode_writer) implies (not hdb.is_open_mode_reader))

				-- Close DB
				hdb.close
				assert ("database is closed", not hdb.is_open)


				-- Check the invariant
				assert("not_open_as_reader_and_writder", hdb.is_open implies (not (hdb.is_open_mode_reader and hdb.is_open_mode_writer)))
				assert("open_as_reader               " , (hdb.is_open and then hdb.is_open_mode_reader) implies (not hdb.is_open_mode_writer))
				assert("open_as_writer				  ", (hdb.is_open and then hdb.is_open_mode_writer) implies (not hdb.is_open_mode_reader))


				-- Open as READER
				hdb.open_reader ("casket.tch")

				assert("open mode as reader", hdb.is_open_mode_reader)

				-- Check the invariant
				assert("not_open_as_reader_and_writder", hdb.is_open implies (not (hdb.is_open_mode_reader and hdb.is_open_mode_writer)))
				assert("open_as_reader               " , (hdb.is_open and then hdb.is_open_mode_reader) implies (not hdb.is_open_mode_writer))
				assert("open_as_writer				  ", (hdb.is_open and then hdb.is_open_mode_writer) implies (not hdb.is_open_mode_reader))


		end

	test_file_does_not_exist
		do
			assert("False",hdb.is_valid_path ("casket.tch") = False)
		end

	test_file_does_exist
		do
			hdb.open_writer_create ("casket.tch")
			assert("True",hdb.is_valid_path ("casket.tch") = True)
		end


	test_tune
		do
			hdb.set_tune (100, 32, 64, hdb.ttcbs.as_natural_8)
			hdb.open_writer_create ("casket.tch")
			assert ("Not has error", not hdb.has_error)
		end

	test_db_copy
		do
			hdb.open_writer_create ("casket.tch")
			hdb.db_copy ("casket2.tch")
			assert ("Not has error", not hdb.has_error)
		end

	test_put
		do
			hdb.open_writer_create ("casket.tch")
			hdb.put("key1", "val1")
			hdb.put("key2", "val2")
			hdb.put("key3", "val3")
			assert ("three elements", hdb.records_number = 3)
			assert ("expected value val1",hdb.retrieve ("key1").is_equal ("val1"))
			assert ("expected value val3",hdb.retrieve ("key3").is_equal ("val3"))
		end


	test_record_size
		local
			value : STRING
		do
			assert("Expected -1",hdb.record_size ("key")=-1)
			hdb.open_writer_create ("casket.tch")
			value := "val1"
			hdb.put("key1", value)
			assert("Expected >0",hdb.record_size ("key1") = value.capacity)
		end

	test_put_async
		do
			hdb.open_writer_create ("casket.tch")
			hdb.put("key1", "val1")
			hdb.put("key2", "val2")
			hdb.put("key3", "val3")
			assert ("three elements", hdb.records_number = 3)
			assert ("expected value val1",hdb.retrieve ("key1").is_equal ("val1"))
			assert ("expected value val3",hdb.retrieve ("key3").is_equal ("val3"))
			hdb.put_asynchronic ("key4", "val4")
			assert ("Expected val4",hdb.retrieve ("key4").is_equal ("val4"))
		end

	test_fwd_keys
		local
			l_list : LIST[STRING]
		do
			hdb.open_writer_create ("casket.tch")
			hdb.put("key1", "val1")
			hdb.put("key2", "val2")
			hdb.put("key3", "val3")
			assert ("three elements", hdb.records_number = 3)
			assert ("expected value val1",hdb.retrieve ("key1").is_equal ("val1"))
			assert ("expected value val3",hdb.retrieve ("key3").is_equal ("val3"))
			l_list := hdb.forward_matching_keys ("k")
			assert("Expected three values", l_list.count = 3)
			l_list := hdb.forward_matching_keys ("ap")
			assert("Expected empty", l_list.is_empty)
		end

feature -- Implementation
	hdb : HDB_API
end


