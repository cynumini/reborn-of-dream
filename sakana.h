#ifndef SAKANA_H
#define SAKANA_H

#include <assert.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#define DYNAMIC_ARRAY_INITIAL_CAPACITY 4

#define da_init(t) dynamic_array_init(sizeof(t))
#define da_deinit(da) dynamic_array_deinit(da)
#define da_push(da, ...) dynamic_array_push(da, &__VA_ARGS__)
#define da_get(da, t, i) (*((t *) dynamic_array_get(da, i)))

typedef struct {
  const size_t stride;
  size_t capacity;
  uint8_t *data;
  size_t len;

} DynamicArray;

static inline DynamicArray dynamic_array_init(const size_t stride) {
  return (DynamicArray){
      .stride = stride,
      .capacity = DYNAMIC_ARRAY_INITIAL_CAPACITY,
      .data = (uint8_t *)malloc(stride * DYNAMIC_ARRAY_INITIAL_CAPACITY),
      .len = 0,
  };
}

static inline void dynamic_array_deinit(DynamicArray *dynamic_array) {
  free(dynamic_array->data);
}

static inline void dynamic_array_push(DynamicArray *da, const void *value) {
  if (da->len + 1 > da->capacity) {
    da->capacity *= 1.5;
    da->data = (uint8_t *)realloc(da->data, da->stride * da->capacity);
  }
  da->len += 1;
  memcpy(da->data + da->stride * (da->len - 1), value, da->stride);
}

static inline void *dynamic_array_get(DynamicArray *da, const size_t index) {
  assert(da->len > index);
  return da->data + da->stride * index;
}

#endif // SAKANA_H
