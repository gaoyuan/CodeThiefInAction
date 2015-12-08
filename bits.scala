// benchmark Java/Scala BigInt/BitSet implementations

import scala.util.Random
import scala.collection.mutable
import scala.collection.immutable
import java.util.BitSet
import java.math.BigInteger

// derived from https://github.com/alexmasselot/benchmark-bitarray/blob/master/src/benchmark/bitarray/TimeIt.scala
def timeInMilli(n: Int, f: () => Unit) = {
  //warm up
  var i = 0;
  while (i < 100) {
    f();
    i+=1
  }
  
  
  val t0 = System.currentTimeMillis()
  i = 0;
  while (i < n) {
    f();
    i+=1
  }
  val t1 = System.currentTimeMillis()
  ( 1000*(t1 - t0) / n)
}


val m = 1000
val nbits = 10000
val maxBit = 100000

val rnd = new Random()


trait MyBitSet {
  def getPosOp: Int => Boolean
  def getCarOp: () => Int
  def getLSBOp: () => Int
  def getEmpOp: () => Boolean
}

def bs2my(s: scala.collection.BitSet): MyBitSet = {
  new MyBitSet() {
    def getPosOp = (x => s(x))
    def getCarOp = (() => s.size)
    def getLSBOp = (() => s.head)
    def getEmpOp = (() => s.isEmpty)
  }
}
def bi2my(s: BigInt): MyBitSet = {
  new MyBitSet() {
    def getPosOp = (x => s.testBit(x))
    def getCarOp = (() => s.bitCount)
    def getLSBOp = (() => s.lowestSetBit)
    def getEmpOp = (() => s == 0)
  }
}
def jbs2my(s: BitSet): MyBitSet = {
  new MyBitSet() {
    def getPosOp = (x => s.get(x))
    def getCarOp = (() => s.cardinality)
    def getLSBOp = (() => s.nextSetBit(0))
    def getEmpOp = (() => s.isEmpty)
  }
}
def jbi2my(s: BigInteger): MyBitSet = {
  new MyBitSet() {
    def getPosOp = (x => s.testBit(x))
    def getCarOp = (() => s.bitCount)
    def getLSBOp = (() => s.getLowestSetBit())
    def getEmpOp = (() => s == BigInteger.ZERO)
  }
}

def run(code: String, test: MyBitSet => Unit) {
  val func = code match {
    case "bigint-scala" => {
      () =>
        for (i <- 0 to m) yield {
          var bi = BigInt(0)
          for (j <- 0 until nbits) {
            bi += (rnd.nextInt(maxBit))
          }
          bi2my(bi)
        }
    }
    case "mutable-scala" => {
      () =>
        for (i <- 0 to m) yield {
          val bi = mutable.BitSet()
          for (j <- 0 until nbits) {
            bi += (rnd.nextInt(maxBit))
          }
          bs2my(bi)
        }
    }
    case "immutable-scala" => {
      () =>
        for (i <- 0 to m) yield {
          var bi = immutable.BitSet()
          for (j <- 0 until nbits) {
            bi += (rnd.nextInt(maxBit))
          }
          bs2my(bi)
        }
    }
    case "bitset-java" => {
      () => 
        for (i <- 0 to m) yield {
          var bi = new BitSet()
          for (j <- 0 until nbits) {
            bi.set(rnd.nextInt(maxBit))
          }
          jbs2my(bi)
        }
    }
    case "bigint-java" => {
      () => 
        for (i <- 0 to m) yield {
          var bi = BigInteger.valueOf(0)
          for (j <- 0 until nbits) {
            bi.add(BigInteger.valueOf(rnd.nextInt(maxBit)))
          }
          jbi2my(bi)
        }
    }
  }

  val sets = func()
  println(code + " " + timeInMilli(1000, {() => sets.map(test(_)).min}))
}

println("pos")
args.foreach(run(_, {x => x.getPosOp(9999) }))
println("lsb")
args.foreach(run(_, {x => x.getLSBOp }))
println("car")
args.foreach(run(_, {x => x.getCarOp }))
println("emp")
args.foreach(run(_, {x => x.getEmpOp }))
