/*

Copyright 2017 The Pony MessagePack Developers

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

*/

use "buffered"
use "ponytest"

actor _TestDecoder is TestList
  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestDecodeNil)
    test(_TestDecodeTrue)
    test(_TestDecodeFalse)
    test(_TestDecodeU8)
    test(_TestDecodeU16)
    test(_TestDecodeU32)
    test(_TestDecodeU64)

class _TestDecodeNil is UnitTest
  fun name(): String =>
    "msgpack/DecodeNil"

  fun ref apply(h: TestHelper) ? =>
    let w: Writer ref = Writer
    let b: Reader ref = Reader

    MessagePackEncoder.nil(w)

    for bs in w.done().values() do
      try
        b.append(bs as Array[U8] val)
      end
    end

    MessagePackDecoder.nil(b)?

class _TestDecodeTrue is UnitTest
  fun name(): String =>
    "msgpack/DecodeTrue"

  fun ref apply(h: TestHelper) ? =>
    let w: Writer ref = Writer
    let b: Reader ref = Reader

    MessagePackEncoder.bool(w, true)

    for bs in w.done().values() do
      try
        b.append(bs as Array[U8] val)
      end
    end

    h.assert_true(MessagePackDecoder.bool(b)?)

class _TestDecodeFalse is UnitTest
  fun name(): String =>
    "msgpack/DecodeFalse"

  fun ref apply(h: TestHelper) ? =>
    let w: Writer ref = Writer
    let b: Reader ref = Reader

    MessagePackEncoder.bool(w, false)

    for bs in w.done().values() do
      try
        b.append(bs as Array[U8] val)
      end
    end

    h.assert_false(MessagePackDecoder.bool(b)?)

class _TestDecodeU8 is UnitTest
  fun name(): String =>
    "msgpack/DecodeU8"

  fun ref apply(h: TestHelper) ? =>
    let w: Writer ref = Writer
    let b: Reader ref = Reader

    MessagePackEncoder.uint_8(w, 9)

    for bs in w.done().values() do
      try
        b.append(bs as Array[U8] val)
      end
    end

    h.assert_eq[U8](9, MessagePackDecoder.u8(b)?)

class _TestDecodeU16 is UnitTest
  fun name(): String =>
    "msgpack/DecodeU16"

  fun ref apply(h: TestHelper) ? =>
    let w: Writer ref = Writer
    let b: Reader ref = Reader

    MessagePackEncoder.uint_16(w, 17)

    for bs in w.done().values() do
      try
        b.append(bs as Array[U8] val)
      end
    end

    h.assert_eq[U16](17, MessagePackDecoder.u16(b)?)

class _TestDecodeU32 is UnitTest
  fun name(): String =>
    "msgpack/DecodeU32"

  fun ref apply(h: TestHelper) ? =>
    let w: Writer ref = Writer
    let b: Reader ref = Reader

    MessagePackEncoder.uint_32(w, 33)

    for bs in w.done().values() do
      try
        b.append(bs as Array[U8] val)
      end
    end

    h.assert_eq[U32](33, MessagePackDecoder.u32(b)?)

class _TestDecodeU64 is UnitTest
  fun name(): String =>
    "msgpack/DecodeU64"

  fun ref apply(h: TestHelper) ? =>
    let w: Writer ref = Writer
    let b: Reader ref = Reader

    MessagePackEncoder.uint_64(w, 65)

    for bs in w.done().values() do
      try
        b.append(bs as Array[U8] val)
      end
    end

    h.assert_eq[U64](65, MessagePackDecoder.u64(b)?)

