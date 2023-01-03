using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            List<int> list = new List<int>() { 4, 32, 1, 99 };
            Func<int, bool> test = x =>
            {
                if (x < 2)
                    return false;
                for (int i = 2; i <= Math.Sqrt(x); i++)
                    if (x % i == 0)
                        return false;
                return true;
            };
            Console.WriteLine(test(1));
            Func<List<int>, int> promax = list =>
            {
                int max = 
            }
            Console.Read();

        }
    }
}
