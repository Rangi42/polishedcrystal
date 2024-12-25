ElevatorFloorNames:
	table_width 1
	dr .B4F
	dr .B3F
	dr .B2F
	dr .B1F
	dr ._1F
	dr ._2F
	dr ._3F
	dr ._4F
	dr ._5F
	dr ._6F
	dr ._7F
	dr ._8F
	dr ._9F
	dr ._10F
	dr ._11F
	dr .Roof
	assert_table_length NUM_FLOORS

.B4F:  db "B4F@"
.B3F:  db "B3F@"
.B2F:  db "B2F@"
.B1F:  db "B1F@"
._1F:  db "1F@"
._2F:  db "2F@"
._3F:  db "3F@"
._4F:  db "4F@"
._5F:  db "5F@"
._6F:  db "6F@"
._7F:  db "7F@"
._8F:  db "8F@"
._9F:  db "9F@"
._10F: db "10F@"
._11F: db "11F@"
.Roof: db "Roof@"
