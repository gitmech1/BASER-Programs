to_do = [];

function add(time, ease=no_ease, factor=2, scale=1) {
	array_push(to_do, [0, time, ease, factor, scale]);
}