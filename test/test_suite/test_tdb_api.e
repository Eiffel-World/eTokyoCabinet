note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_TDB_API

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
			create tdb.make
		end

	on_clean
			-- <Precursor>
		do
			tdb.delete
			tdb.close
		end

feature -- Test routines

	test_put_map
			-- New test routine
		local
			cols : MAP_API[STRING,STRING]
			r_cols : MAP_API[STRING,STRING]
			str : STRING
		do

			tdb.open ("casket.tct", tdb.owriter.bit_or (tdb.ocreat))
			assert ("Empty Database", tdb.records_number = 0)
			create cols.make
			cols.put ("name", "javier")
			cols.put ("age", "30")
			cols.put ("lang", "es,en")
			tdb.put_map ("key", cols)
			assert ("One Element", tdb.records_number = 1)

			create cols.make
			cols.put ("name", "diego")
			cols.put ("age", "50")
			cols.put ("lang", "it,en")
			cols.put ("skills", "db,scripting")
			tdb.put_map ("key2", cols)
			assert ("Two Elements", tdb.records_number = 2)

			create r_cols.make_by_pointer (tdb.get_map ("key"))
			assert ("Expected Name", r_cols.get ("name").is_equal ("javier"))
			assert ("Expected age", r_cols.get ("age").is_equal ("30"))

			str := tdb.get_string ("key")
			assert ("Tab string record", str.is_equal ("name%Tjavier%Tage%T30%Tlang%Tes,en"))
		end


	test_search
			-- New test routine
		local
			cols : MAP_API[STRING,STRING]
			r_cols : MAP_API[STRING,STRING]
			str : STRING
			qry : TDB_QUERY
			l_list : LIST_API[STRING]
		do

			tdb.open ("casket.tct", tdb.owriter.bit_or (tdb.ocreat))
			assert ("Empty Database", tdb.records_number = 0)
			create cols.make
			cols.put ("name", "javier")
			cols.put ("age", "30")
			cols.put ("lang", "es,en")
			tdb.put_map ("key", cols)
			assert ("One Element", tdb.records_number = 1)

			create cols.make
			cols.put ("name", "diego")
			cols.put ("age", "50")
			cols.put ("lang", "it,en")
			cols.put ("skills", "db,scripting")
			tdb.put_map ("key2", cols)
			assert ("Two Elements", tdb.records_number = 2)

			create r_cols.make_by_pointer (tdb.get_map ("key"))
			assert ("Expected Name", r_cols.get ("name").is_equal ("javier"))
			assert ("Expected age", r_cols.get ("age").is_equal ("30"))

			create qry.make_by_pointer (tdb.tdb)

			qry.add_condition ("age", qry.qcnumge, "20")
			qry.add_condition ("lang", qry.qcstror, "es,en")
			qry.set_order ("name", qry.qostrasc)
			qry.set_limit (10,0)

			create l_list.make_by_pointer (qry.search)
			assert ("two elements", l_list.elements = 2)
			assert ("Expected key2",l_list.value (1).is_equal ("key2"))
			create r_cols.make_by_pointer ( tdb.get_map (l_list.value (1)))
			assert ("Expected Name diego",r_cols.get ("name").is_equal ("diego"))
			assert ("Expected Age 50",r_cols.get ("age").is_equal ("50"))
			str := tdb.get_string ("key")
			assert ("Tab string record", str.is_equal ("name%Tjavier%Tage%T30%Tlang%Tes,en"))
		end

feature -- Implementation
	tdb : TDB_API
end


