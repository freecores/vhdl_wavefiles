-------------------------------------------------------------------------------
-- Project    : VHDL WAVE files 
-------------------------------------------------------------------------------
-- File       : Testbench-ea.vhd
-- Author     : Alexander Lindert <alexander.lindert@fh-hagenberg.at>
-- Created    : 2008-08-20
-- Last update: 2008-08-23
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2008 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  
-- 2008-08-20  1.0    
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.WaveFiles.all;

entity Testbench is
end entity;

architecture bhv of Testbench is

  -- signal iMono   : signed(7 downto 0);
  -- type   aPCM16 is array(natural range<>) of signed(15 downto 0);
--  signal iStereo : aPCM16(0 to 1);
--  signal i10     : aPCM16(0 to 9);
  signal ts            : time;
  signal ReaderInfo    : aWaveFileInfo;
  signal WriteData, ReadData : integer;
  signal Mono          : integer;
  signal Stereo        : aIntArray(0 to 1);
  signal Ch10          : aIntArray(0 to 9);
  
begin
  
  Read : process
    file Reader          : aFileHandle;
    file Writer          : aFileHandle;
    variable vReaderInfo : aWaveFileInfo;
    variable vFileName   : string(1 to 11);
    variable vMono       : integer;
    variable vStereo     : aIntArray(0 to 1);
    variable vCh10       : aIntArray(0 to 9);
     variable vWriteData, vReadData : integer;
  begin
    for i in 0 to 3 loop
      case i is
        when 0      => vFileName := "iMono.wav  ";
        when 1      => vFileName := "iStereo.wav";
        when 2      => vFileName := "iCh10.wav  ";
        when 3      => vFileName := "iBit32.wav ";              
        when others => null;
      end case;
      OpenWaveFileRead(vFileName, Reader, vReaderInfo);
      case i is
        when 0      => vFileName := "oMono.wav  ";
        when 1      => vFileName := "oStereo.wav";
        when 2      => vFileName := "oCh10.wav  ";
        when 3      => vFileName := "oBit32.wav ";               
        when others => null;
      end case;
      OpenWaveFileWrite(vFileName, Writer, vReaderInfo);
      ReaderInfo <= vReaderInfo;
      vReadData := vReaderInfo.DataSize;
      vWriteData := vReaderInfo.DataSize;
      ts         <= 1 sec /(vReaderInfo.SamplingRate);
      wait for 0 ns;
      wait for ts;

      while vReadData > 0 loop
        case vReaderInfo.Channels is
          when 1 =>
            ReadSample(Reader, vMono,
                       vReadData, vReaderInfo.DataTyp);
            Mono <= vMono;
            WriteSample(Writer, vMono,
                        vWriteData, vReaderInfo.DataTyp);
          when 2 =>
            ReadSamples(Reader, vStereo, vReadData,
                        vReaderInfo.Channels, vReaderInfo.DataTyp);
            Stereo <= vStereo;
            WriteSamples(Writer, vStereo, vWriteData,
                         vReaderInfo.Channels, vReaderInfo.DataTyp);
          when 10 =>
            ReadSamples(Reader, vCh10, vReadData,
                        vReaderInfo.Channels, vReaderInfo.DataTyp);
            Ch10 <= vCh10;
            WriteSamples(Writer, vCh10, vWriteData,
                         vReaderInfo.Channels, vReaderInfo.DataTyp);   
          when others =>
            report "Untestet" severity note;
            vReaderInfo.DataSize := 0;
        end case;
        ReadData <= vReadData;
        WriteData <= vReadData;
        wait for ts;
      end loop;
      file_close(Reader);
      file_close(Writer);
    end loop;

    wait;
  end process;

end architecture;


