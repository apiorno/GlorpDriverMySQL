maintenance
cleanPool
	"flushes connections that have closed whilst idle in the pool"

	self queue flushAllSuchThat: [ :each | each isConnected not ]