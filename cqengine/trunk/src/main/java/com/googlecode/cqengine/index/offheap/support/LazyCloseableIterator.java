package com.googlecode.cqengine.index.offheap.support;

import com.googlecode.concurrenttrees.common.LazyIterator;

/**
 * @author niall.gallagher
 */
public abstract class LazyCloseableIterator<T> extends LazyIterator<T> implements CloseableIterator<T> {
}
