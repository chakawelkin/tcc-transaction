package org.mengyun.tcctransaction.storage;

import java.util.HashMap;
import java.util.Map;

public enum StorageType {

    MEMORY("MEMORY"),

    JDBC("JDBC"),

    REDIS_CLUSTER("REDIS_CLUSTER"),

    REDIS("REDIS"),

    SHARD_REDIS("SHARD_REDIS"),

    ROCKSDB("ROCKSDB"),

    REMOTING("REMOTING"),

    CUSTOMIZED("CUSTOMIZED");

    private static Map<StorageType, String> storageClassNameMap = new HashMap<>();

    static {
        storageClassNameMap.put(MEMORY, "org.mengyun.tcctransaction.storage.MemoryTransactionStorage");
        storageClassNameMap.put(JDBC, "org.mengyun.tcctransaction.storage.JdbcTransactionStorage");
        storageClassNameMap.put(REDIS_CLUSTER, "org.mengyun.tcctransaction.storage.JedisClusterTransactionStorage");
        storageClassNameMap.put(REDIS, "org.mengyun.tcctransaction.storage.RedisTransactionStorage");
        storageClassNameMap.put(SHARD_REDIS, "org.mengyun.tcctransaction.storage.ShardJedisTransactionStorage");
        storageClassNameMap.put(ROCKSDB, "org.mengyun.tcctransaction.storage.RocksDbTransactionStorage");
        storageClassNameMap.put(REMOTING, "org.mengyun.tcctransaction.storage.RemotingTransactionStorage");
    }

    private String value;

    StorageType(String value) {
        this.value = value;
    }

    public static String getStorageClassName(StorageType storageType) {
        return storageClassNameMap.get(storageType);
    }

    public String value() {
        return this.value;
    }

}
