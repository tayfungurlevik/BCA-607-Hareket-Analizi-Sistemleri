using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace ViconParser
{
    class Program
    {
        static void Main(string[] args)
        {
            string filepath = "vicon_all_labelled.txt";
            using (StreamReader reader = new StreamReader(filepath))
            {
                using (StreamWriter writer = new StreamWriter("vicon_parsed.txt"))
                {
                    
                    do
                    {
                        string line = reader.ReadLine();
                        if (line.Contains("Frame Number:"))
                        {
                            int frameNumber = int.Parse(line.Split(':')[1].Trim());
                            Console.WriteLine(frameNumber);
                            writer.Write(frameNumber + ",");
                            
                        }
                        if (line.Contains("Markers (5):"))
                        {
                            string marker1Line = reader.ReadLine();
                            int startIndex = marker1Line.IndexOf('(');
                            int endIndex = marker1Line.IndexOf(')');
                            string marker1Pozitions = marker1Line.Substring(startIndex + 1, endIndex - startIndex - 1);
                            Console.WriteLine(marker1Pozitions);
                            string marker2Line = reader.ReadLine();
                            startIndex = marker2Line.IndexOf('(');
                            endIndex = marker2Line.IndexOf(')');
                            string marker2Pozitions = marker2Line.Substring(startIndex + 1, endIndex - startIndex - 1);
                            Console.WriteLine(marker2Pozitions);
                            string marker3Line = reader.ReadLine();
                            startIndex = marker3Line.IndexOf('(');
                            endIndex = marker3Line.IndexOf(')');
                            string marker3Pozitions = marker3Line.Substring(startIndex + 1, endIndex - startIndex - 1);
                            Console.WriteLine(marker3Pozitions);
                            string marker4Line = reader.ReadLine();
                            startIndex = marker4Line.IndexOf('(');
                            endIndex = marker4Line.IndexOf(')');
                            string marker4Pozitions = marker4Line.Substring(startIndex + 1, endIndex - startIndex - 1);
                            Console.WriteLine(marker4Pozitions);
                            string marker5Line = reader.ReadLine();
                            startIndex = marker5Line.IndexOf('(');
                            endIndex = marker5Line.IndexOf(')');
                            string marker5Pozitions = marker5Line.Substring(startIndex + 1, endIndex - startIndex - 1);
                            Console.WriteLine(marker5Pozitions);
                            writer.WriteLine("{0},{1},{2},{3},{4}", marker1Pozitions, marker2Pozitions,
                                marker3Pozitions, marker4Pozitions, marker5Pozitions);
                        }
                    } while (!reader.EndOfStream);
                }
               
                
                
            }
            
        }
    }
}
